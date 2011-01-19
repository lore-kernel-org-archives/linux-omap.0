From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to
 kernel-2.6.37
Date: Wed, 19 Jan 2011 13:06:35 +0200
Message-ID: <20110119130635.8842cb51.jhnikula@gmail.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1ASLGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 06:06:41 -0500
Received: by fxm20 with SMTP id 20so734024fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 03:06:40 -0800 (PST)
In-Reply-To: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, 19 Jan 2011 18:57:33 +0800
Bob Liu <lliubbo@gmail.com> wrote:

> I think the reason is 2.6.37 using omap-serial driver.
> After I force it using 8250 serial driver, it works fine.
> 
> Any ideas?

Change ttySx to ttyOx in your bootloader
arguments, /etc/inittab and /etc/securetty. Previous thread here:

http://marc.info/?l=linux-omap&m=129253181926201&w=2

-- 
Jarkko
