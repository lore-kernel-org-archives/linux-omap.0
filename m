From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH v5 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
Date: Fri, 11 Dec 2015 11:21:55 -0600
Message-ID: <CADhT+weU7cqqq1t_D_B7HZ8ZxZiyneC+t7Cr7nK5nWzoRFQToA@mail.gmail.com>
References: <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
 <1449842554-29898-1-git-send-email-boris.brezillon@free-electrons.com>
 <20151211161008.056a0f47@bbrezillon>
 <CADhT+wcNFxD6Zv9w8W0sontVWa6zOkHjyK42Tw=Y_1X2XCTZfQ@mail.gmail.com>
 <20151211180855.47c95df2@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20151211180855.47c95df2@bbrezillon>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Stefan Agner <stefan@agner.ch>, linux-sunxi@googlegroups.com, linux-mtd@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-samsung-soc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dinh Nguyen <dinguyen@altera.com>, Sebastian
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2015 at 11:08 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Hi Dinh,
>
> On Fri, 11 Dec 2015 10:50:21 -0600
> Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
>> Hi Boris,
>>
>> On Fri, Dec 11, 2015 at 9:10 AM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>> > + Dinh (who made commit 2a0a288ec258)
>> >
>> > Also added back the Fixes tag.
>> >
>> > On Fri, 11 Dec 2015 15:02:34 +0100
>> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>> >
>> >> Unregister the NAND device from the NAND subsystem when removing a denali
>> >> NAND controller, otherwise the MTD attached to the NAND device is still
>> >> exposed by the MTD layer, and accesses to this device will likely crash
>> >> the system.
>> >>
>> >> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> >
>> > Fixes: 2a0a288ec258 ("mtd: denali: split the generic driver and PCI layer")
>> >
>> >> ---
>> >> Changes since v4:
>> >> - remove Cc stable and fixes tags
>> >> - calculate the dma buffer size before calling nand_release()
>> >>
>> >>  drivers/mtd/nand/denali.c | 6 ++++--
>> >>  1 file changed, 4 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
>> >> index 67eb2be..fdfea05 100644
>> >> --- a/drivers/mtd/nand/denali.c
>> >> +++ b/drivers/mtd/nand/denali.c
>> >> @@ -1622,9 +1622,11 @@ EXPORT_SYMBOL(denali_init);
>> >>  /* driver exit point */
>> >>  void denali_remove(struct denali_nand_info *denali)
>> >>  {
>> >> +     int bufsize = denali->mtd.writesize + denali->mtd.oobsize;
>> >> +
>> >> +     nand_release(&denali->mtd);
>> >>       denali_irq_cleanup(denali->irq, denali);
>> >> -     dma_unmap_single(denali->dev, denali->buf.dma_buf,
>> >> -                      denali->mtd.writesize + denali->mtd.oobsize,
>> >> +     dma_unmap_single(denali->dev, denali->buf.dma_buf, bufsize,
>> >>                        DMA_BIDIRECTIONAL);
>>
>> Not sure what is the need to add bufsize here, but the commit message
>> doesn't reflect the change.
>
> You were not in Cc of the first version (my fault), but Brian pointed
> that the mtd fields could be in an unknown state after the
> nand_release() call (this is currently not the case, but it change in
> the future). The idea is to pre-compute the DMA buffer size before
> releasing the mtd/nand device to prevent any future issues.
>
> I don't think it is worth mentioning this in the commit message,
> because these are just implementation details, but I can add the
> following comment before the bufsize declaration:
>
>         /*
>          * Pre-compute DMA buffer size to avoid any problems in case
>          * nand_release() ever changes in a way that mtd->writesize and
>          * mtd->oobsize are not reliable after this call.
>          */
>
> What do you think?
>

Ah, perfect! With the updated comment,

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thanks,
Dinh
