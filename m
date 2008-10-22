From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: dsp-bridge synch issues
Date: Wed, 22 Oct 2008 19:53:19 +0300
Message-ID: <94a0d4530810220953l23ce3794i18b518472b735289@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.247]:53473 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYJVQxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 12:53:21 -0400
Received: by rv-out-0708.google.com with SMTP id k29so4247528rvb.0
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 09:53:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Hari Kanigeri <h-kanigeri2@ti.com>

Hi,

I wrote a very simple DSP test and I'm having some synchronization issues.
http://github.com/felipec/dsp-dummy

Basically:
  DSPNode_PutMessage (core->node, &msg, DSP_FOREVER);
  usleep (4000);
  DSPNode_GetMessage (core->node, &msg, 0);

If I remove the usleep, I get:

DSPNodeCreate succeeded
DSPNode_run succeeded
WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102
WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
WMD_DEH_Notify: DSP_SYSERROR, errInfo = 0x102

If I add it:

DSPNodeCreate succeeded
DSPNode_run succeeded

Any ideas?

-- 
Felipe Contreras
