From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: RE: Problem with DSP TMS320C55xx on OMAP5912
Date: Wed, 01 Nov 2006 15:46:26 +0000
Message-ID: <BAY102-F35EC0D929029302085CA5CA9F80@phx.gbl>
References: <20061101075003.86216.qmail@web36404.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061101075003.86216.qmail@web36404.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tung,

   The CCS debugging suite is really unwieldy for doing basic debugging=20
operations on the OMAP. The main problem is that the GPP is constantly=20
trying to maintain a strange hold on the DSP, reserving control of its de=
bug=20
connections. So, when you try and load a program, set breakpoints or=20
otherwise alter the state of the DSP, while linux and the GPP are running=
,=20
you will invariably get errors. There are a few things you can do that ma=
ke=20
things go easier depending on your requirements:

- Reset the jumpers appropriately to turn the board on in DSP only mode.=20
This is only good if you don't need access to the peripherals, but its ve=
ry=20
useful for step by step hardware debugging of major code loops that would=
=20
run solely on the DSP

- After you have loaded your application from the GPP side through linux=20
(Maybe a-la RF6?) you can go to the file menu of CCS and do a "load symbo=
ls=20
only" which will sync CCS and the code running on the DSP. It may allow y=
ou=20
to set breakpoints, though it is not totally reliable.

Make sure you have the latest version of DSP/BIOS compiled and built with=
=20
your program, it seems to be less buggy than the default versions. Also=20
evaluation versions of CCS 3.1 appear to be less stable. I hope some of t=
his=20
helps.

Thanks,
Andy

>From: Tung Dang <tungsys@yahoo.com>
>To: linux-omap-open-source@linux.omap.com
>Subject: Problem with DSP TMS320C55xx on OMAP5912
>Date: Tue, 31 Oct 2006 23:50:03 -0800 (PST)
>
>Hi all,
>When i using Code Composer Studio (CCS) from TI to simulate the function=
s=20
>of my program , the CCS verbal a error in the Messages Window :
>Trouble running Target CPU: Check the linker command file / map file for=
=20
>any part of the program going into reserved area and correct the problem=
=20
>when Program Counter is 0x0  NOTE: Reset the target, reload the correcte=
d=20
>program and continue execution
>Pls help me , what kind of this error ? What is the root problem ?
>
>
>
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>Thank you and Best Regards  !
>Dang Hoang Tung
>email : tungsys@yahoo.com
>Student
>University of Technology
>Department of Computer Science
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
>---------------------------------
>  Check out the New Yahoo! Mail - Fire up a more powerful email and get=20
>things done faster.
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Find a local pizza place, music store, museum and more=85then map the bes=
t=20
route!  http://local.live.com?FORM=3DMGA001
