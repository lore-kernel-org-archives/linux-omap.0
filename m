From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 1/5] ARM: dev_archdata: add private iommu extension
Date: Sun, 2 Oct 2011 20:48:41 +0200
Message-ID: <CAK=WgbY+YN6aj4+RUdPz068+H+vtnEx0_SbKuKc++S4AHRS_hw@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-2-git-send-email-ohad@wizery.com>
	<20110927013001.GA20588@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110927013001.GA20588@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Cousson Benoit <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 4:30 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Blech. =A0Oh well. =A0Not much point in doing something different if x86
> uses a void*.

x86 probably does this because two different implementations needs to
plug their private data there: intel-iommu plugs there a 'struct
device_domain_info *' and amd_iommu uses it with a 'struct
iommu_dev_data *'.

On ARM we'd eventually end up with even a bigger variety, and I guess
that even if we'd use a type-safe member here, it would itself end up
having 'void *'.

If it looks reasonable to you, can I please have your Ack ?

Russell, can you please take a look too and ack/nack ?

Thanks,
Ohad.
