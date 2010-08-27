From: rockefeller <rockefeller.lin@innocomm.com>
Subject: RE:[PATCH 2/9] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Fri, 27 Aug 2010 10:29:56 +0800
Message-ID: <1282876196.13328.45.camel@I097020.innocomm.com>
References: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vfe4.seed.net.tw ([139.175.252.119]:60870 "EHLO
	vfe4.seed.net.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab0H0DFp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 23:05:45 -0400
Received: from [210.68.184.147] (port=33334 helo=[192.168.16.64])
	by vfe4.seed.net.tw:g with esmtp (Seednet 4.69:1)
	id 1OoohT-000CRU-HF
	for linux-omap@vger.kernel.org; Fri, 27 Aug 2010 10:29:51 +0800
In-Reply-To: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Tony,
   In the implementation of omap_mux_init_signal(char *muxname, int val)
in arch/arm/mach-omap2/mux.c, it will modify the muxname of
caller that passed in and not recover it, did you mean to implement 
to do so?(I try to explain my point of view as 2 examples below).

[Example 1]
For a XIP device(NOR type), a caller function might be codeed like
below:

omap_mux_init_signal("muxname.mode7", 0xFFFF);

and in this case, the string "muxname.mode7" might be a const string
and not be modified.

[Example 2]
For a NAND device, a caller might be coded like below:

static char *pin_mux_name = "muxname.mode7";

function1()
{
omap_mux_init_signal(pin_mux_name, 0xFFFF);
}

function2()
{
omap_mux_init_signal(pin_mux_name, 0x0000);
}

void main()
{
function1();
function2();
}

Because "muxname.mode7" in in RAM is modifiable, after function call
to function1(), the *pine_mux_name will be "muxname" and therefore when
calls to function2() to try to set this pin in mode7 with value 0x0000
might be un-expected result.


