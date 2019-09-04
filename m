From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/4] more ti-sysc driver changes for v5.4
Date: Wed, 4 Sep 2019 17:26:55 +0200
Message-ID: <CAK8P3a27NB+8cz=dF5nSL_bACV5HDuUZLoZFUEvjjs7M6Oqm5g@mail.gmail.com>
References: <pull-1567016893-318461@atomide.com>
 <pull-1567016893-318461@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com-2>
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

On Wed, Aug 28, 2019 at 8:35 PM Tony Lindgren <tony@atomide.com> wrote:
> more ti-sysc driver changes for omap variants for v5.4
>
> Few changes mostly to deal with sgx SoC glue quirk for omap36xx that
> is needed for the related sgx SoC glue dts branch. The other changes
> are to simplify sysc_check_one_child() sysc_check_children() to be void
> functions, and detect d2d module when debugging is enabled.

Pulled into arm/late, thanks!

     Arnd
