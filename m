From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clockdomain: another fix for v4.6-rc
Date: Wed, 13 Apr 2016 09:16:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604130916040.9379@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Tony

The following changes since commit 3ca4a238106dedc285193ee47f494a6584b6fd2f:

  ARM: OMAP2+: hwmod: Fix updating of sysconfig register (2016-03-26 23:08:55 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6-rc/omap-fixes-b

for you to fetch changes up to 1cbabcb9807e31e87ef3a12af76ea025ceb582d3:

  ARM: DRA7: clockdomain: Implement timer workaround for errata i874 (2016-04-10 11:43:57 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: clockdomain: another fix for v4.6-rc

For DRA7xx platforms, add a workaround for missed timer interrupts
that appears to be due to an integration bug (erratum i874)

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/omap-fixes-b-for-v4.6-rc/20160413020850/

(The DRA7xx board here has not yet been added into the testbed.)

- ----------------------------------------------------------------
Keerthy (1):
      ARM: DRA7: clockdomain: Implement timer workaround for errata i874

 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXDg48AAoJEMePsQ0LvSpLj50P/1kFXG6VQJBmSjXSR6MIjCwG
c42jiLw2NfnBJTm/kprvBeHl6YUsEK0Cn3wZ/N2Ng8VmIDJtCfC+UGs1CPO7gRrC
roxpUypwvOcSBuQfjaspBb0lsh/gV6yyI3p+EusUwTn/oqfbh4Oxi3gpmsU89s5Q
Ae1dm/Rtigyh6KZ5IKY9Kxv6tV4J4CAP60TUc417ASZxUN9u8z9Dec2XtN44ChFa
yG13EhcIXo8hMD+g7i9tN3amog3qRnAXPiJY8YQAnGV/gKGER6Rhq71FwkIyFD4a
g5oUBRmO5r2uyPBPGRgBV5aRt5LkNJ/v18z/f3wxA0GVI4bVW0VitIxQc/DhDqmh
EnhVTeFmA96vLAQYZG8udWxjiiF0EUri6cU/p/q9QkWJiWNQFwDMThllLWOhMLoM
h5P8kWAFolF33mS5gfFplwsD1WG5QrrHdGYnOaVIqYmLMEcTpLNkIBjnc/kydTqr
QDU2earV14q+26jL5SIkbFYZRotOYvdiFHZwLcz4ZOlHQr9akTAZtRQd0IOZa/XI
DXtaKJDvRdbSm0EjkdIINRifLWD0XOy9hFhse30tZAh0pWNo586RNtJ1p20MnXOC
L2BUgrTSDeCuzGN0vpmbFkgXfzY8jtXt3/rJNUPZSrwPEgvQzf9xiolm/x1NFMEH
ahHZ9xEDAwKFXrOMgE5k
=wgYv
-----END PGP SIGNATURE-----
