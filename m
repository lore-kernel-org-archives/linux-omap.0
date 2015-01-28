From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Wed, 28 Jan 2015 09:04:48 -0800
Message-ID: <20150128170448.GP28663@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com>
 <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com>
 <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150123164756.GB7718@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150123 08:54]:
> 
> Should be usable for NFSroot with all the patches I've sent using the
> ti u-boot and and appended DTB uImage. Sorry not all of it is yet in
> Linux next though, I'll push a current testing branch at some point
> today. The mainline u-boot was at least missing the davinci_emac
> support the last time I tried.

Seems to be all in today's Linux next and I just verified that
3.19.0-rc6-next-20150128-06478-g30720bbe is booting on 8168-evm.

Regards,

Tony
