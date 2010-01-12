From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 3/6] Regulator: Use common regulator supplies and init
 	data structs
Date: Tue, 12 Jan 2010 12:10:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7586@dbde02.ent.ti.com>
References: <1262973479-32570-1-git-send-email-anuj.aggarwal@ti.com>
 <6ed0b2681001110441j75863ab8l467fdf2660328171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34127 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab0ALGkQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 01:40:16 -0500
In-Reply-To: <6ed0b2681001110441j75863ab8l467fdf2660328171@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> Your common supply file has VMMC2 supply configured for 1.8V which is
> wrong for pandora (it uses 3.1V because it has a transceiver attached
> to MMC2 that handles level shifting transparently).
> 
> I think you should leave pandora board file alone, because it uses
> many supplies differently than your common file configures them
> (VAUX1-VAUX4, VSIM differ, only VMMC1, VDAC and VPLL2 match, which is
> not that much duplication).
[Aggarwal, Anuj] My mistake :(
 Although I have marked it as RED in my notes, I still modified it. I 
will leave VMMC2 in this file only.
But I am not able to find so many regulators as you mentioned above in 
this file. I can only see VMMC1 and VMMC2, out of which VMMC2 is 
different from the common configuration.
Where is the gap?
