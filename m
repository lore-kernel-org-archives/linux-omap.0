From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 00/35] defconfig: Cleanup from old entries
Date: Sat, 10 Jun 2017 18:43:51 +0200
Message-ID: <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
References: <20170608160836.12196-1-krzk@kernel.org>
 <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liviu Dudau <liviu.dudau@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-sh@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 09, 2017 at 09:59:48PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
> > similar obsolete entries in other files.
> >
> > Except the ARM, no dependencies.
> > For ARM, the rest of patches depend on the first change (otherwise
> > it might not apply cleanly).
> 
> Great work!
> 
> I looked at all the ARM patches, and everything looks good to me (the
> changlog linewrapping may be suboptimal for readability in some cases,
> if I had to say anything negative ;-) ).
> 
> Please add my Acked-by to the ARM patches and send a pull request.

Thanks, I'll send you ARM part in pull request.

As for the rest, I think respective arch/platform maintainers should
take it.

Best regards,
Krzysztof
