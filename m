From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH][RFC] OMAP4: Keypad Support for OMAP4430
Date: Wed, 22 Jul 2009 19:25:57 +0530
Message-ID: <5d5443650907220655j4fddb1a0ud590a968199a0ca2@mail.gmail.com>
References: <54980.192.168.10.89.1248270623.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:47420 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbZGVNz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 09:55:59 -0400
In-Reply-To: <54980.192.168.10.89.1248270623.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Syed Rafiuddin <rafiuddin.syed@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi Syed,

On Wed, Jul 22, 2009 at 7:20 PM, Syed Rafiuddin<rafiuddin.syed@ti.com> wrote:
> This patch adds OMAP4 support to the Keypad driver. This patch adds
> OMAP4 register addresses and configures registers for OMAP4.
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>


>From the first look of this driver, I think omap-keypad driver is
reaching its limit. There are lot's of cpu_is_xxx lurking in this
drivers. I like drivers those who use them at minimum.

First step to do is that, please remove omap2 gpio based keypad logic
to matrix_keypad.c, that will be omap-keypad.c bit clean, and then
start merging omap4 keypad code.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
