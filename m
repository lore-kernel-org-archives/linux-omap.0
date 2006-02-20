From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 13:33:28 -0400
Message-ID: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

HI,

This series of patches adds modularisation in alsa files for omap so that
makes possible to use the same alsa omap core files for different boards.
Regarding the original omap alsa support, the codec specific functions
were removed from file omap-aic23.c (which now is called omap-alsa.c)
and inserted in a specific file for this codec. Similar action was made
for tsc2101 codec, based in former oss drivers.
With this series of patches omap now have support for osk and H2 boards.
Besides codec files, the mixer file has its support added for H2.
This work was developed by me and Mika Laitio.

Summary:

-New architecture: extraction of codec dependent code from main alsa file
-Support for board H2
-Creation of codec alsa file for codec aic23 (from existing alsa work)
-Creation of codec alsa file for codec tsc2101 from oss
-Migration of specific codec configuration to platform_data
-Improvement of function probe in omap-alsa driver
-Creation of the mixer for tsc2101

Some issues where we would like to hear also others opinions
1) Codecs (omap-alsa-tsc2101.c and omap-alsa-aic23.c) from the alsa
drivers are now put to arch/arm/mach-omap1 directory to allow board
specific configuration.
Advantages
-  codecs are now configurable in the board-code (board-h2, board-osk)
which specifies the codecs specific function pointers.
-  board can now configure even multible different alsa-codecs if there
exist need for that. (one for mcbsp1, another for mcbsp2)
Disadvantages
-codecs part of the alsa drivers are now always linked to the Image even
if the driver itself is selected to be build as a module.
When codec is changed, you need to replace the Image and that forces you
to reboot instead of simply using "rmmod" and "modprobe" commands.

2) If it is acceptable to put the codecs under arch directory, would
plat-omap be better location than arch-omap1, for mcbsp supported
codecs? (Are there any omap2 boards with aic23 or tsc2101 codecs?)

Comments and tests are welcome.


Cheers,
Daniel
--
INdT - Manaus - Brazil
