From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] ti-sysc driver changes for v5.3
Date: Wed, 4 Sep 2019 17:26:20 +0200
Message-ID: <CAK8P3a1Hh8nFe7h0Jr7tf_aoarvwr3utD7LrFf9rV_OePL-+Zg@mail.gmail.com>
References: <pull-1566599057-142651@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1566599057-142651@atomide.com>
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
> Driver changes for ti-sysc for v5.4
>
> Few changes to prepare for using a reset driver for PRM rstctrl mostly
> to deal with the clocks for reset. Then few minor clean-up patches and
> SPDX license identifier changes, and add a MAINTAINERs file entry.

Pulled this one into an arm/late branch, together with the three
other pull requests that depend on this one.

Don't worry about the arm/late name, I expect to send this off
together with the other branches, it's just easier for me to
describe what's in each of the top-level branches this way.

       Arnd
