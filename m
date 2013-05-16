From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix __init section mismatch for
 _enable_preprogram
Date: Thu, 16 May 2013 11:04:25 -0700
Message-ID: <20130516180425.GE5600@atomide.com>
References: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23014 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab3EPSE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 14:04:29 -0400
Content-Disposition: inline
In-Reply-To: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

* jean-philippe francois <jp.francois@cynove.com> [130513 02:34]:
> Hi,
>=20
> _enable_preprogram is marked as __init, but is called from _enable
> which is not. Without this patch, the board oopses after init. Tested
> on custom hardware and on beagle board xM.
>=20
> Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

Thanks applying into omap-for-v3.10/fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
