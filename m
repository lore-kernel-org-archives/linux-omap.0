From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] dts changes for omap variants for v5.4
Date: Tue, 3 Sep 2019 16:01:37 +0200
Message-ID: <CAK8P3a3SQKV3qCebMpvUgPZE5DVjwfJ-pub=FWwbnyY4m=iVeQ@mail.gmail.com>
References: <pull-1566599057-142651@atomide.com>
 <pull-1566599057-142651@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1566599057-142651@atomide.com-2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 24, 2019 at 12:24 AM Tony Lindgren <tony@atomide.com> wrote:
> ----------------------------------------------------------------
> dts changes for omap variants for v5.4
>
> Remove regulator-boot-off properties that we never had in the mainline
> kernel so they won't do anything. We add stdout-path for gta04, and
> make am335x-boneblue use am335x-osd335x-common.dtsi file.

Pulled into arm/dt, thanks!

       Arnd
