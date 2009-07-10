From: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: [PATCH 2:2][MTD][NAND]omap : Adding DMA mode support in nand
 prefetch/post-write
Date: Fri, 10 Jul 2009 15:02:24 +0300
Message-ID: <1247227344.20721.363.camel@localhost.localdomain>
References: <63362.192.168.10.89.1247226916.squirrel@dbdmail.itg.ti.com>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30126 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZGJMDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 08:03:05 -0400
In-Reply-To: <63362.192.168.10.89.1247226916.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, dwmw2@infradead.org, david-b@pacbell.net, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 2009-07-10 at 17:25 +0530, vimal singh wrote:
> +	/* The fifo depth is 64 bytes. We have a sync at each frame and fra=
me
> +	 * length is 64 bytes.
> +	 */
> +	int buf_len =3D len/64;

To optimize performance it is better not to rely on gcc and use <<

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
