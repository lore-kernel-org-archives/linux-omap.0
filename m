From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: [patch] Convert cbus driver code to use platform APIs consistently
Date: Mon, 08 Jun 2009 20:55:54 +0100
Message-ID: <20090608205554.8257711w03d8isi2@lidskialf.net>
References: <20090520151907.GC8308@atomide.com>
	<20090522184720.10616mt8vpjglk3k@lidskialf.net>
	<20090522193359.17514ptwyl8kdbls@lidskialf.net>
	<20090522231826.12833dwwkvi7rv0g@lidskialf.net>
	<20090523023901.33341jpwcx6nd70g@lidskialf.net>
	<20090523014717.GB9283@atomide.com>
	<20090523121108.14776dli2aeyapkw@lidskialf.net>
	<20090523123040.16971ty5wndy6mow@lidskialf.net>
	<20090523132812.14461t6dlahg2ew0@lidskialf.net>
	<20090523142542.10985fjvcwu3k9s0@lidskialf.net>
	<20090601231839.GD22956@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:40113 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZFHTzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 15:55:52 -0400
In-Reply-To: <20090601231839.GD22956@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

Recent changes in the drivers/base/platform.c exposed an inconsistency  
in the cbus drivers; they weren't matching platform_divers with  
platform_devices, which causes all sorts of structure casting issues  
within the base platform code since it assumes this.

Signed-off-by: Andrew de Quincey <adq@lidskialf.net>


