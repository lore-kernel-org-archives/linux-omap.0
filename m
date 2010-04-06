From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [ASK] OMAP 3430 LDP Trouble
Date: Wed, 7 Apr 2010 01:17:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC6@dbde02.ent.ti.com>
References: <o2nd9ca78711004061241w5fe76cfcp79ca3670beff758@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0DFTsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 15:48:06 -0400
In-Reply-To: <o2nd9ca78711004061241w5fe76cfcp79ca3670beff758@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>, Vimal Singh <vimal.newwork@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Tar Gz wrote:
> if NAND support is currently missing for OMAP3430 LDP,,how i boot my
> ldp again like before?...any idea?
> 

<snip>

If I understand you correctly, you now have a non-booting LDP, and want
to get a bootloader flashed on it?

You may need to do a serial boot.

Maybe this (old, and no longer maintained) page will help?

<https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing>

- Anand
