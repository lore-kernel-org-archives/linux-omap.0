From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 05/11] TEMP: OMAP3: pm: remove serial resume / idle calls from idle path
Date: Mon, 25 Jul 2011 19:33:48 +0300
Message-ID: <1311611628.5826.14.camel@sokoban>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com> <1309861677-2769-6-git-send-email-t-kristo@ti.com> <20110722235150.GB13706@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55819 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1GYQdw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 12:33:52 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6PGXprr014517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:33:52 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6PGXpBk022835
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:33:51 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20110722235150.GB13706@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

On Sat, 2011-07-23 at 01:51 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Jul 05, 2011 at 01:27:51PM +0300, Tero Kristo wrote:
> > This is no longer needed as it will be handled within serial driver itself.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> isn't this introducing a regression ? Should this, maybe, be merged into
> next patch ?
> 

Patches tagged TEMP are not meant for integration, just for testing
purposes.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

