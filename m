From: "andrew chalmers" <achalmers@ellex.com>
Subject: How do I disable filesystem caching for MMC
Date: Wed, 30 Aug 2006 17:33:11 +0930
Message-ID: <F886F08A2006F7478D83B2249BDD97578E3DB5@ellex-adc1.ellexmedical.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

After some effort I have managed to get the MMC support working under
the montavista 2.4.20 distribution for the OSK5912.
I've even managed to setup card detect signal and hotplug support.
Everything seems to work well. I can mount and unmount MMCs, format
them, and read and write file to them. The hot plug automatically mounts
and unmounts the cards filesystem when a card is inserted or removed.

Everything, that is, except for the fact that after writing something to
the card I have to wait about 35 seconds for the filesystem to flush to
the card. This can be a problem when you want to pull the card out
straight after writing to it.

I have tried the sync and dirsync mount options for the vfat filesystem.

Does anyone have any idea how to convince the filesystem to flush all
the writes and not cache them for 35 seconds?

Help appreciated,

Andrew Chalmers.
