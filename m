From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 18 May 2012 22:42:52 +0530
Message-ID: <CAJe_ZherKototBYoc3d47JJbYjYxAMJbQ5RmjupoMyqNjdQYEQ@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
 <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
 <201205161942.20296.arnd@arndb.de>
 <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
 <4FB55242.2080501@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FB55242.2080501@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 18 May 2012 01:02, Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> Now, the DMA node for an on-SoC DMAC would be in soc.dtsi. Typically,
> the DMAC is connected to many on-SoC devices, and hence soc.dtsi would
> need to specify the routing information for all those devices to avoid
> duplicating it in every board.dts. Now, if you have some DMA requests
> that go off-SoC, the board.dts file might want to add to the routing
> table to indicate what clients connect to those DMA requests. However,
> there's no way in the device tree compiler right now to add to a
> property; you can only completely replace it. That would entail
> duplicating the entire routing information from soc.dtsi into each
> board.dts that wanted to add to it - a bad situation. Splitting the
> routing information into chunks in the client nodes avoids this issue
> entirely.
>
 As already noted by Russell, the dma setup is different than irq or
gpio which deliberately lend to off-SoC attachments. Without fpga'ing,
I find it hard to imagine request-signals going off-SoC.

I only see the issue of different boards sporting a different sub-sets
of clients i.e, a map entry may or may exist for a board but it would
be same for two boards that have it.
 Maybe we could somehow separate out the chan-map and private-data
into board.dts ?
Even if it has to stay in soc.dts, we still have the benefit of having
dmac agnostic client nodes.

cheers!
