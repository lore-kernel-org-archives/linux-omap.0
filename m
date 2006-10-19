From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Subject: Re: Disable DSPGW fails
Date: Thu, 19 Oct 2006 16:10:13 +0200
Message-ID: <200610191610.14278.openembedded@hrw.one.pl>
References: <4523752A.8020601@gmail.com>
	<200610041211.53114.openembedded@hrw.one.pl>
	<20061019135028.GH9983@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061019135028.GH9983@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dnia czwartek, 19 pa=C5=BAdziernika 2006 15:50, Tony Lindgren napisa=C5=82:

> This patch disables using McBSP without CONFIG_OMAP_DSP. I've posted
> another patch that should keep the old functionality, can you please try
> that out?

My patch was made to get kernel built at all. Then Philip Balister changed=
=20
default configuration so we did not have this problem again. I do not have=
=20
board to test kernel.

=2D-=20
JID: hrw-jabber.org
OpenEmbedded developer/consultant
