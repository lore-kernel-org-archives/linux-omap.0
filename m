From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] defconfig changes for omaps for v5.1
Date: Fri, 15 Feb 2019 16:46:44 +0100
Message-ID: <CAK8P3a0N3J3uvFN0JxqBx+pJbUuQaoLgGu73_XLeOD6_fxBHzQ@mail.gmail.com>
References: <pull-1550167958-188990@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1550167958-188990@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 14, 2019 at 7:13 PM Tony Lindgren <tony@atomide.com> wrote:

> ----------------------------------------------------------------
> Defconfig changes for omaps
>
> Drop PROVE_LOCKING as it should not be enabled in the defconfig. It
> causes quite a bit overhead as noted in the patch description.
>
> Then let's update omap2plus_defconfig for dropped options and moved
> options. That way makesavedefconfig can actually be used to generate
> patches against omap2plus_defconfig.

Thanks a lot for doing it this thoroughly, pulled into arm/defconfigs,

      Arnd
