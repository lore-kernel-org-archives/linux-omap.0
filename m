From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
	if/else
Date: Tue, 14 Jul 2009 16:17:25 +0300
Message-ID: <1247577445.13580.47.camel@pcarmody-desktop>
References: <1247569366.13580.9.camel@pcarmody-desktop>
	 <7A436F7769CA33409C6B44B358BFFF0C011E5ED158@dlee02.ent.ti.com>
	 <1247570430.13580.16.camel@pcarmody-desktop>
	 <20090714.153035.258117413.Hiroshi.DOYU@nokia.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50223 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbZGNNPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 09:15:06 -0400
In-Reply-To: <20090714.153035.258117413.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Cc: "nm@ti.com" <nm@ti.com>, "x0095840@ti.com" <x0095840@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>

On Tue, 2009-07-14 at 14:30 +0200, Doyu Hiroshi (Nokia-D/Helsinki)
wrote:
> From: "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>
> Subject: RE: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an if/else
> Date: Tue, 14 Jul 2009 13:20:30 +0200
> 
> > On Tue, 2009-07-14 at 13:05 +0200, ext Menon, Nishanth wrote:
> > > Phil,
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Phil Carmody
> > > > Sent: Tuesday, July 14, 2009 6:03 AM
> > > > 
> > > > On Fri, 2009-07-10 at 01:51 +0200, ext Guzman Lugo, Fernando wrote:
> > > > > Thanks for the patch, it only has indentation problems, this is the
> > > > checkpatch output:
> > > > >
> > > > > WARNING: suspect code indent for conditional statements (8, 12)
> > > > > #34: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
> > > > > +       if (DSP_SUCCEEDED(status)) {                    \
> > > > > +           if (unlikely((src) == NULL) ||              \
> > > > >
> > > > > WARNING: line over 80 characters
> > > > > #36: FILE: drivers/dsp/bridge/pmgr/wcd.c:154:
> > > > > +               unlikely(copy_from_user(dest, src, (elements) *
> > > > sizeof(*(dest))))) { \
> > > > >
> > > > > WARNING: suspect code indent for conditional statements (8, 12)
> > > > > #46: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
> > > > > +       if (DSP_SUCCEEDED(status)) {                    \
> > > > > +           if (unlikely((dest) == NULL) ||
> > > > \
> > > > >
> > > > > WARNING: line over 80 characters
> > > > > #48: FILE: drivers/dsp/bridge/pmgr/wcd.c:166:
> > > > > +               unlikely(copy_to_user(dest, src, (elements) *
> > > > sizeof(*(src))))) { \
> > > > >
> > > > > total: 0 errors, 4 warnings, 48 lines checked
> > > > >
> > > > > Could you please fix that warning please?
> > > > 
> > > > I suspect the only way to fix those warnings would either introduce
> > > > other warnings, or \
> > > Gentle query: Have we already tried this or is it just a suspicion?
> > 
> > Being an Englishman, I use various forms of irony more than others do;
> > that particular form's called "litotes". It indeed is not a suspicion -
> > I tried about 4 or 5 variations, none of which were both readable and
> > warning-free. In the end I decided that whatever was closest to the
> > original would be safest.
> > 
> > > > 							would \
> > > > 							lead \
> > > > 							to \
> > > > 							utterly \
> > > > 							unread- \
> > > > 							able \
> > > > 							code.
> > > > 
> > > > If you check how and why the original TI-originated version of the code
> > > > does not follow the linux coding standards, the difficulties we would
> > > > have making a warning-free patch of it should be apparent.
> > > 
> > > Past is past. The idea was not to introduce anymore warning code.
> > 
> > The TI code would trigger the following 4 warnings:
> > WARNING: suspect code indent for conditional statements (4, 12)
> > WARNING: line over 80 characters
> > WARNING: suspect code indent for conditional statements (4, 12)
> > WARNING: line over 80 characters
> > 4 warnings isn't more than 4 warnings, it's no change - and as I mention
> > above, in the absence of an easy fix, that was deliberate.
> 
> I am not sure if these copy_from_user() wrapping are practically
> useful or not. It may be enough just to use kernel API as is. But if
> there are some reason to requires strict parameter checkings or
> debugging feature support for these family here, introducing inline
> functions for them, instead of macro, may be another option?

I did mention that possibility to Ameya. In the 21st century, I think we
should be able to trust the compiler to generate identical code from
inline functions as functional macros. (Are we allowed to use 'restrict'
pointers?)

> For example,
> 
> 	Modified drivers/dsp/bridge/pmgr/wcd.c
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 86812c6..c8b26c0 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -146,16 +146,23 @@
>  #define MAX_BUFS	64
>  
>  /* Following two macros should ideally have do{}while(0) */
> +static inline void cp_fm_usr(void *to, const void __user *from,
> +			     DSP_STATUS *err, unsigned long n)
> +{
> +	if (DSP_FAILED(err))

*err

> +		return;
>  
> -#define cp_fm_usr(dest, src, status, elements)    \
> -    if (DSP_SUCCEEDED(status)) {\
> -	    if (unlikely(src == NULL) ||				\
> -		unlikely(copy_from_user(dest, src, elements * sizeof(*(dest))))) { \
> -		GT_1trace(WCD_debugMask, GT_7CLASS, \
> -		"copy_from_user failed, src=0x%x\n", src);  \
> -		status = DSP_EPOINTER ; \
> -	} \
> -    }
> +	if (unlikely(!from)) {
> +		*err = DSP_EPOINTER ;
> +		return;
> +	}
> +
> +	if (unlikely(copy_from_user(to, from, n * sizeof(*(to))))) {

additional () not needed any more.

> +		GT_1trace(WCD_debugMask, GT_7CLASS,
> +			  "%s failed, from=0x%x\n", src, __func__);
> +		*err = DSP_EPOINTER ;
> +	}
> +}
>  
>  #define cp_to_usr(dest, src, status, elements)    \
>      if (DSP_SUCCEEDED(status)) {\
> @@ -525,7 +532,7 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
>  	char *pszPathName = NULL;
>  	DSP_STATUS status = DSP_SOK;
>  
> -	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
> +	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, &status, 1);
>  	if (DSP_FAILED(status))
>  		goto func_end;
>  	pathSize = strlen_user((char *)
> ....

That kind of thing would work. There would be loads of changes (62, by
the looks of it), but at least they are trivial ones.

Phil

