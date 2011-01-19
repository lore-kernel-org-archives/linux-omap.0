From: Felipe Balbi <balbi@ti.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update
 to kernel-2.6.37
Date: Wed, 19 Jan 2011 13:06:07 +0200
Message-ID: <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33571 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab1ASLGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 06:06:15 -0500
Received: by gwb11 with SMTP id 11so209056gwb.11
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 03:06:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
> Any ideas?

s/console=ttyS2,115200n8/console=ttyO2,115200n8/

on your CMDLINE.

-- 
balbi
