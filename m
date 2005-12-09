From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: building XDAIS algorithms
Date: Fri, 9 Dec 2005 13:47:40 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402CC6097@dlee02.ent.ti.com>
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
To: Carlos Davila <davila@dfwair.net>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Carlos

> Thanks for your response Jon. The .pjt file also has settings=20
> for an "Archiver" and a "DspBiosBuilder". I assume the=20
> DspBiosBuilder is not needed since DspBios is already=20
> incorporated into RF6, but the archiver appears to be what=20
> generates the for_ti.l55l library file used by RF6.=20
> Can this also be done by gcc?


Yes I believe this can be done via gcc. The archiver is included with
the linux c55x dsp tools. The archiver is located in the
cgtools-c5500-v2.56/bin/ directory and it is the tool called ar55.=20

After you have compiled the source files and generated the *.obj files
you can create a library by doing something like:

ar55 -r [libname] [obj file names]

Eg. ar55 -r fir_ti.l55l fir_ti.o55 fir_ti_filter.o55 fir_ti_ialg.o55
fir_ti_vt.o55

Regards,
Jon
