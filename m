From: "Ola Helm" <ola.hel@gmail.com>
Subject: Trasnferring u-boot to P2 730
Date: Wed, 29 Mar 2006 12:07:04 +0300
Message-ID: <3d3153f60603290107w2dcb1289r9a4667a1c23ed49c@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I have searched the archives and and tried to find some discussion about th=
e
issue and also checked out the /pub/documentation but none seems to exist
which would answer. I'm trying to find out how to transfer u-boot to P2
board. I'm interested to hear how have you managed to get the u-boot  - and
furthermore anything - to board.

My situation is that board have SysBoot 1.18 in it. It does recognize and
accept MMC and finds linking file, but it does not accept image itself. It
gives a message:"Valid image could not be found". I have tried self-compile=
d
and downloaded u-boot.out, u-boot.bin and u-boot files with no result, can'=
t
get a reason for that..

I'm also intrested is there a way to download the u-boot via serial cable o=
r
other transfer method. I have tried to download with hyperterminal, minicom
and OST Tool, but none seems to have any reaction to sysboot. I'm not sure
am I using correct addresses in OST tool for flashing/RAM download thoug, I
should use the debug board in some way I don't know, perhaps switches are
not in correct positions in either of boards (in target I (think) have trie=
d
them in almost all possible positions and in debug board I mainly changed
position of SW4-6 enabling/disabling RS-232 in either board and SW4-7
changing UART 1 and 2) etc. etc.

I have also tried to have connection via JTAG but it does not get connected
even though I tried different switch / jumper settings, now
JP1: 1-2
JP2: 1-2
JP3: 2-3
(device does work, the reason is somewhere else).

Ideas?

/O
