From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: RE: [PATCH 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
	complete mess
Date: Mon, 06 Jul 2009 15:47:28 +0300
Message-ID: <1246884448.25105.66.camel@pcarmody-desktop>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
	 <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
	 <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A2C9D6FC@dlee06.ent.ti.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49546 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbZGFMpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 08:45:43 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A2C9D6FC@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Fri, 2009-07-03 at 20:39 +0200, ext Guzman Lugo, Fernando wrote:
> Please see my comments below.
> 
> > -----Original Message-----
> > From: Ameya Palande [mailto:ameya.palande@nokia.com]
> > Sent: Thursday, July 02, 2009 9:21 AM
> > To: linux-omap@vger.kernel.org
> > Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> > Subject: [PATCH 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
> > complete mess
> > 
> > From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> > 
> > If you followed some failure paths, it was entirely possible that
> > you'd attempt to MEM_Free a user-space pointer, because it wouldn't
> > have been replaced with a kernel-space copy yet. Now replace all
> > untouched pointers with NULL, so the cleanup does nothing for those
> > ones.
> > 
> > Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > ---
> >  drivers/dsp/bridge/pmgr/wcd.c |   95 +++++++++++++++++++++++-------------
> > ----
> >  1 files changed, 55 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> > index 00b2770..2fd9f8c 100644
> > --- a/drivers/dsp/bridge/pmgr/wcd.c
> > +++ b/drivers/dsp/bridge/pmgr/wcd.c
> > @@ -880,83 +880,99 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
> >  {
> >  	s32 i, len;
> >  	DSP_STATUS status = DSP_SOK;
> > -       char *temp;
> > -	s32 argc = args->ARGS_PROC_LOAD.iArgc;
> > +	char *temp;
> > +	s32 count = args->ARGS_PROC_LOAD.iArgc;
> >  	u8 **argv, **envp = NULL;
> > 
> > +	DBC_Require(count > 0);
> > +	DBC_Require(count <= MAX_LOADARGS);
> > 
> > -	DBC_Require(argc > 0);
> > -	DBC_Require(argc <= MAX_LOADARGS);
> > -
> > -	argv = MEM_Alloc(argc * sizeof(u8 *), MEM_NONPAGED);
> > -	if (argv == NULL)
> > +	argv = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
> > +	if (!argv) {
> >  		status = DSP_EMEMORY;
> > +		goto func_cont;
> > +	}
> > 
> > -	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, argc);
> > -	if (DSP_FAILED(status))
> > +	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, count);
> > +	if (DSP_FAILED(status)) {
> > +		MEM_Free(argv);
> > +		argv = NULL;
> >  		goto func_cont;
> > +	}
> > 
> > -	for (i = 0; DSP_SUCCEEDED(status) && (i < argc); i++) {
> > +	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
> >  		if (argv[i] != NULL) {
> >                          /* User space pointer to argument */
> > -                       temp = (char *) argv[i];
> > -                       len = strlen_user((char *)temp);
> > +			temp = (char *) argv[i];
> > +			len = strlen_user((char *)temp);
> >  			/* Kernel space pointer to argument */
> >  			argv[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
> > -			if (argv[i] == NULL) {
> > +			if (argv[i] != NULL) {
> > +				cp_fm_usr(argv[i], temp, status, len);
> > +			} else {
> >  				status = DSP_EMEMORY;
> > -				break;
> >  			}
> 
> Brackets should be removed from if and else sentences if only one statement follow them.

In normal C, yes. However, your code uses rather unpleasant macros for
cp_fm_usr() which will mess things up horribly inside an if/else without
curly brackets. 

The real fix should be to fix the macro as well to use the 
do {} while 0
technique - I shall propose that to Ameya.

> > -			cp_fm_usr(argv[i], temp, status, len);
> > -			if (DSP_FAILED(status))
> > +
> > +			if (DSP_FAILED(status)) {
> > +				while (i < count)
> > +					argv[i++] = NULL;
> 
> In this point memory has been allocated to argv[i] and you are assigned argv[i] to null losing that reference and provoking a memory leak. Other think due to the check for freeing " for (i = 0; (i < count) && argv[i]; i++)" it only frees memory until it finds the first null (or until count), assigning argv[i+1] to null is enough and the "while" is not needed.

Agree - good catch!
Ditto other 2, will resend.

(Regarding patch 2, we'll re-work that too.)

Phil


