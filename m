From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Wed, 22 Oct 2008 14:46:11 -0700
Message-ID: <200810221446.11415.david-b@pacbell.net>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:36929 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751628AbYJVVqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 17:46:13 -0400
In-Reply-To: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 22 October 2008, Juha Kuikka wrote:
> - =A0 =A0 =A0 __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
> + =A0 =A0 =A0 __raw_readsl(nand->IO_ADDR_R, buf, len / 4);
> =A0}

Shouldn't that have been __raw_readsw() though?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
