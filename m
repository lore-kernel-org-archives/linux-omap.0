From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: building XDAIS algorithms
Date: Fri, 9 Dec 2005 09:06:20 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402CC5CC7@dlee02.ent.ti.com>
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
To: Carlos Davila <davila@dfwair.net>, Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Carlos,=20

> I have been adapting the base RF6 application that comes with=20
> the TI Linux Dsp Tools. The base application implements an=20
> FIR filter and a volume control. The executable code that=20
> implements the XDAIS FIR filter algorithm comes in library=20
> files located in the rf_3_11_dsp/lib directory and appears to=20
> have already been built, i.e. the executable XDAIS FIR=20
> algorithm code is not built when the dsp side RF6 application=20
> is built, rather, it appears to have been built with code=20
> composer studio using the project file in=20
> rf_3_11_dsp/src/fir_ti/. Is it possible to build the dsp-side=20
> XDAIS algorithm executables using only the Linux DSP Tools or=20
> the montavista tools, without CCS?
>=20
> Thank you,
> Carlos
>=20


This should be possible. However, you will need to create a Makefile for
the FIR filter project. The *.pjt file that CCS uses is a text file and
so you can view this with any text editor. In the *.pjt file you will
see a list of the source files included in the project, plus the
compiler and linker options used for building the project and creating
the *.out file.=20

Regards,
Jon
=20
