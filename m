From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: dsp-bridge synch issues
Date: Wed, 22 Oct 2008 14:40:17 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E13FA46D7@dlee03.ent.ti.com>
References: <94a0d4530810220953l23ce3794i18b518472b735289@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbYJVTk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 15:40:26 -0400
In-Reply-To: <94a0d4530810220953l23ce3794i18b518472b735289@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Hi Felipe,

> I wrote a very simple DSP test and I'm having some synchronization issues.
> http://github.com/felipec/dsp-dummy
> 
> Basically:
>   DSPNode_PutMessage (core->node, &msg, DSP_FOREVER);
>   usleep (4000);
>   DSPNode_GetMessage (core->node, &msg, 0);

-- The DSP_SYSERROR is reported by DSP side of the Bridge.
Try passing -1 (infinite wait) as the timeout to DSPNode_GetMessage function instead of 0. 
You can refer to the dmmcopy.c sample file in the bridge tarball on omapzoom.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, October 22, 2008 11:53 AM
> To: linux-omap@vger.kernel.org List; Kanigeri, Hari
> Subject: dsp-bridge synch issues
> 
> Hi,
> 
> I wrote a very simple DSP test and I'm having some synchronization issues.
> http://github.com/felipec/dsp-dummy
> 
> Basically:
>   DSPNode_PutMessage (core->node, &msg, DSP_FOREVER);
>   usleep (4000);
>   DSPNode_GetMessage (core->node, &msg, 0);
> 
> If I remove the usleep, I get:
> 
> DSPNodeCreate succeeded
> DSPNode_run succeeded
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
> 
> If I add it:
> 
> DSPNodeCreate succeeded
> DSPNode_run succeeded
> 
> Any ideas?
> 
> --
> Felipe Contreras

