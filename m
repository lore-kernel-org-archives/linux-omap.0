From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API implementation
Date: Wed, 25 Apr 2012 00:51:09 +0300
Message-ID: <CANOLnOM29Mn2BTydX=C5FEu6evkS5W8eL87RwNmppJWuVLGjAQ@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 7:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Since the driver becomes useless without DMA_ENGINE, we probably want
a 'depends on'?



--=20
Gra=C5=BEvydas
