From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Linux DSP Tools or CCS-IDE?
Date: Tue, 21 Mar 2006 08:32:11 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF403FE04EF@dlee02.ent.ti.com>
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
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi All,


> >         Currently i am working with OMAP5912 starter kit. In the DSP
> > application development, there are two options provided one with
Linux
> DSP
> > Tools and another with CCS-IDE with emulator. Is there any
feature-wise
> > difference between these two tools?. How many of you have preferred
CCS-
> IDE
> > instead of Linux DSP Tools? Which one is better for the application
> > development?. Please help me in this regard.
>=20
> 	They are effectively the same thing: CCS is a front end for the
same
> tools that you get with the Linux DSP Tools.  It just comes down to
what
> kind of environment you are more familiar with.  Linux users are
> traditionally more comfortable with IDE, so will tend to prefer CCS,
> whilst GNU/Linux users are typically more comfortable with using the
> shell, and as such will prefer to use the Linux DSP Tools in the way
> they normally code.  If you have no preference either way, CCS would
> probably be the easiest to learn with.
>=20

With regard to building DSP applications, Matthew is correct with CCS
being GUI based front end and the DSP Linux tools having a shell
interface. However, CCS does offer additional features for debugging
that aren't available with the DSP Linux tools. For example, if you
purchase a JTAG emulator you can use CCS to download code to the DSP and
debug it on the h/w. Even if you do not have an emulator CCS does
provide a simulator for the C55x DSP core and you can use this to test
algorithms etc. However, the simulator does not have the ability to
simulate all the h/w features of the device.=20

Although JTAG emulators can be expensive (starting around ~$1300) they
can be quite useful as you can use them to view memory, CPU registers
and peripheral registers. So this can help reduce debug time.=20

With the CCS simulator, you can still view the CPU registers and memory,
but peripheral features are not supported as different C55x based DSPs
differ in peripheral mix.=20

If you would like to try CCS then you can always download a 120 day free
trial version from the following link:
http://focus.ti.com/dsp/docs/dspsupportaut.tsp?sectionId=3D3&tabId=3D416&=
fam
ilyId=3D44&toolTypeId=3D30

Please note that CCS is only available for windows. However, you can
still invoke the compiler from an ms-dos prompt. =20

Regards,
Jon
