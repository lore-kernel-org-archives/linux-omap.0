From: andrzej zaborowski <balrogg@gmail.com>
Subject: Command Time-Out values in MMC
Date: Sat, 28 Jan 2006 20:48:26 +0100
Message-ID: <fb249edb0601281148g745d146cy@mail.gmail.com>
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
while browsing the MMC driver sources I noticed that the CTO (Command
Time-Out) register is written a value 0xff in one place (exactly,
here: http://www.kernel.org/git/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6=
.git;a=3Dblob;h=3D35708dbf9d8e0f41687caeb70e7dde3f216a86a9;hb=3D9ca18d5394c=
5e6b2c74ddc52abaed81df530ff1d;f=3Ddrivers/mmc/omap.c#l847),
while the OMAP5910 documentation (exactly, this document:
http://focus.ti.com/dsp/docs/dspsupporttechdocsc.tsp?sectionId=3D3&tabId=3D=
409&familyId=3D325&abstractName=3Dspru680)
states something like:
[...]
0x01: One clock cycle
0xFD: 253 clock cycles
The 0xFF and 0xFE cannot be used.
[...]

Is this intentional? It seems to cause no problems, but setting 0xfd
instead also didn't break anything for me. Is this limit also
mentioned in documentation for other OMAP boards?
(If this is intentional, please ignore me.)
Regards,
Andrzej Zaborowski
