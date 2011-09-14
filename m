From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 5/6] iommu/intel: announce supported page sizes
Date: Wed, 14 Sep 2011 08:11:34 +0300
Message-ID: <CAK=WgbbVTFb3vh7CA+teA4Un9-BBaAVO5m-rq2V6CMKv0++YFg@mail.gmail.com>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
	<1315942288-17297-5-git-send-email-ohad@wizery.com>
	<1315949582.2687.204.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315949582.2687.204.camel@shinybook.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 14, 2011 at 12:32 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2011-09-13 at 22:31 +0300, Ohad Ben-Cohen wrote:
>> + * Traditionally the IOMMU core just handed us the mappings directly,
>> + * after making sure the size is an order of a 4KB page and that the
>> + * mapping has natural alignment.
>> + *
>> + * To retain this behavior, we currently advertise that we support
>> + * all page sizes that are an order of 4KB.
>
> This is wrong. We do not support 4000-byte pages. We only support
> 4096-byte pages. 4KiB, not 4kB.
>
> Please fix.

Sure thing; I'll s/KB/KiB throughout the patch set.

Do I have your ACK otherwise ?

Thanks,
Ohad.
