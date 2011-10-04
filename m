From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 2/5] ARM: OMAP: omap_device: add a method to set iommu
	private archdata
Date: Tue, 4 Oct 2011 23:40:13 +0200
Message-ID: <4E8B7D3D.9000204@ti.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-3-git-send-email-ohad@wizery.com>
	<87sjni9aql.fsf@ti.com>
	<CAK=WgbZhz8LcAYZEY3qqRkX4E_wtspWp09Eq9G=5VdpoMMF1FQ@mail.gmail.com>
	<87botwk4gw.fsf@ti.com>
	<CAK=WgbYaEPBUz_J11+f+W+G9uUG3E6aQ-5=X9bj2nRhij-w-Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbYaEPBUz_J11+f+W+G9uUG3E6aQ-5=X9bj2nRhij-w-Sw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 10/4/2011 9:54 PM, Ohad Ben-Cohen wrote:
> On Tue, Oct 4, 2011 at 8:15 PM, Kevin Hilman<khilman@ti.com>  wrote:
>> The approach is OK with me, but I'm a bit torn about whether or not to
>> merge this since the need for this should go away when converting to DT.
>
> I guess it will still take some time until our boards are fully
> functional with DT, so I think we should regard this as an interim
> solution. Without this patch, a huge deal of code consolidation and
> generalization is gated (namely - generic iommu and dma api, and
> everything that depends on it, e.g. rpmsg/remoteproc).
>
>> Is anyone working on IOMMU DT description?
>
> Unless Benoit is, I'll happily pick this up.

Cool, a volunteer... You're in.

Thanks,
Benoit
