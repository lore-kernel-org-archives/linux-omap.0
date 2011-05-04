From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 3/4] omap: move detection of NAND CS to common-board-devices
Date: Wed, 4 May 2011 11:54:28 -0400
Message-ID: <217399A1-383F-4F69-B9D1-0421A48481C8@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il> <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru> <44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru> <4DC0F469.9030406@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:39057 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab1EDPyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 11:54:47 -0400
In-Reply-To: <4DC0F469.9030406@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

On May 4, 2011, at 2:38 AM, Mike Rapoport wrote:

> On 05/04/11 07:10, Oleg Drokin wrote:
>> Ok, so here's a simple patch to save everyone trouble, I guess.
>> 
>> Though on the other hand I can imagine that perhaps including this generic common-board-devices.c
>> might not be desirable for people that don't use anything from that file.
> Since the common-board-devices.c has TWL initialization I doubt there would a
> board that does not use it at all...

Actually the twl init you have is somewhat inflexible.
E.g. on the Nook Color the 1st i2c bus has the twl and some other devices, but I don't see how
to put more than just the twl on the first bus with your common code.

Bye,
    Oleg