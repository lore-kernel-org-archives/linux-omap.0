From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 16:50:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007121638530.10598@xanadu.home>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<201007122231.16283.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_g8GqyUWL5EpXoEfuThNOTw)"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <201007122231.16283.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Walker <dwalker@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Eric Miao <eric.miao@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_g8GqyUWL5EpXoEfuThNOTw)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Mon, 12 Jul 2010, Arnd Bergmann wrote:

> On Monday 12 July 2010 20:50:29 Uwe Kleine-König wrote:
> > 
> > [1] The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> > 
> >   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> > 
> > are available in the git repository at:
> >   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/defconfig/reduced-v2.6.35-rc1
> 
> BTW, looking at the most common entries in there, I think we might at some
> point want to change some of the defaults in the respective Kconfig files.
> Right now an empty defconfig would result in a configuration without
> file system, networking or modules:

We need to come up with a scheme that allows for expressing the most 
likely options you might want if you have machine x and/or machine y 
selected.  Those likely options are for drivers corresponding to 
hardware soldered on the board or integrated into a SOC and therefore 
which is not "optional".  Right now this information is carried in the 
defconfig files.  Without that you need to lookup various datasheets and 
wade through thousands of Kconfig options.  Compared to that, stuff like 
filesystems and networking protocols are optional items that currently 
are more arbitrarily included into or excluded from the defconfig files.  

I think that the first category of options should automatically be 
selected on a per machine basis depending on BASE_CONFIG or the like and 
expressed directly in the Kconfig files.  Typically there are very few 
of those (like a dozen or so for some example target I looked at).


Nicolas

--Boundary_(ID_g8GqyUWL5EpXoEfuThNOTw)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Boundary_(ID_g8GqyUWL5EpXoEfuThNOTw)--
