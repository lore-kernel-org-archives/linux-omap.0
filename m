From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
Date: Mon, 3 May 2010 20:58:55 +0100
Message-ID: <20100503195855.GA18647@n2100.arm.linux.org.uk>
References: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222Ab0ECT7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 15:59:13 -0400
Content-Disposition: inline
In-Reply-To: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Albin Tonnerre <albin.tonnerre@free-electrons.com>, linux-omap@vger.kernel.org

On Mon, May 03, 2010 at 02:51:25PM -0500, Sergio Aguirre wrote:
> This should complement changes done in:
>=20
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
>=20
>       arm: add support for LZO-compressed kernels
>=20
> It missed to do the respective changes in '.gitignore' file.
>=20
> Also, add vmlinux to the list, which is generated also during
> the build.
>=20
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Ok.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
