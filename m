From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Building a RF6 example with DSP Gateway 3.3
Date: Mon, 19 Dec 2005 08:32:44 -0400
Message-ID: <a0580c510512190432sc2973f9g@mail.gmail.com>
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,


  I'm trying to compile and execute using DSPGW 3.3 the simple RF6
(XDAIS - Reference Framework 6) example that comes with the Linux
DSP Tools (OSK5912 and Linux 2.6.x). To do that, I'm following
the how-to that comes with Linux DSP Tools and can be found in
($LINUX_DSP_TOOLS_DIR)/doc/LinuxDspTools_GettingStartedGuide_v98.pdf
  Linux DSP Tools DSP Development for TI OMAP5912
  Getting Started Guide
  Document Version 0.98
  PRELIMINARY

  It explains how to do that using Montavista 3.1. However,
after changing makefiles and environment variables, the compilation
process was fine. But, when I try to execute the 'app.out' generated
binary file with:

 # dspctl start app.out

it gets a configuration error. Like that:

omapdsp: DSP address 0060072c / size 00000004 is not valid!
Can't determine reset vector address

  And, when I do:

# dspctl version app.out

It gets:

DSP Gateway binary version 3.1 or before.

  It seams like the binary is too old.
  Is there any way to build a RF6 (Reference Framework 6) example and run i=
t
using DSP Gateway linux drivers / tokliBIOS / tinkernel into a 2.6.x runnin=
g
linux kernel?
  It seams that RF6 uses a link (DSP <--> ARM9) quite different of the one
provided by DSP Gateway project. Is that true?

Thanks,


--
Eduardo Bezerra Valentin
