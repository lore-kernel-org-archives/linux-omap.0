From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sat, 18 Oct 2008 23:19:57 +0300
Message-ID: <6ed0b2680810181319l6aa9f76co652a89778eefcdd1@mail.gmail.com>
References: <1224357743-23060-1-git-send-email-notasas@gmail.com>
	 <20081018195518.GQ31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:9973 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYJRUT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 16:19:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1153520rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 18 Oct 2008 13:19:58 -0700 (PDT)
In-Reply-To: <20081018195518.GQ31842@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

On Sat, Oct 18, 2008 at 10:55 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, Oct 18, 2008 at 10:22:23PM +0300, Grazvydas Ignotas wrote:
>> +     hsmmc_init();
>> +     usb_musb_init();
>> +     usb_ehci_init();
>
> Are you guys really using both ??
>
> do you have an otg port on pandora ??

Yup, we have both EHCI and OTG. See http://openpandora.ca/ . EHCI was
functional several weeks back, now it locks up just like on beagle.
Will resend soon with coding style changes..
