From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: Re: Problem with DSP TMS320C55xx on OMAP5912
Date: Wed, 01 Nov 2006 17:50:11 +0000
Message-ID: <BAY102-F18758420938D7A81546771A9F80@phx.gbl>
References: <20061101173835.469.qmail@web36407.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061101173835.469.qmail@web36407.mail.mud.yahoo.com>
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

   Ah. I haven't used the simulator before. That is a weird error to get=20
from it. It sounds like you don't have all the right files for running th=
e=20
simulation, hence why it breaks when you try and launch. But, since I=20
haven't used the simulator before, I really can't say.

Sorry,
Andy

>From: Tung Dang <tungsys@yahoo.com>
>To: dejanigma@hotmail.com
>CC: linux-omap-open-source@linux.omap.com
>Subject: Re: Problem with DSP TMS320C55xx on OMAP5912
>Date: Wed, 1 Nov 2006 09:38:35 -0800 (PST)
>
>Hi Andy,
>Thank you very much for helping me !
>
>But I only use the simulator of CCS 3.1 (platinum edition) to simulate t=
he=20
>function of DSP side, not any relate to GPP side. My purpose is to  use =
the=20
>sim55.cdb configuration template of CCS to simulate and debug the major=20
>code loops on TMS320C55xx .
>Please, do you have any suggestion for me  ?
>
>Thanks ,
>Tung .
>
>
>linux-omap-open-source-request@linux.omap.com wrote:
>------------------------------
>
>Message: 3
>Date: Wed, 01 Nov 2006 15:46:26 +0000
>From: "Abot Botbot"
>Subject: RE: Problem with DSP TMS320C55xx on OMAP5912
>To: linux-omap-open-source@linux.omap.com
>Message-ID:
>Content-Type: text/plain; format=3Dflowed
>
>Tung,
>
>    The CCS debugging suite is really unwieldy for doing basic debugging
>operations on the OMAP. The main problem is that the GPP is constantly
>trying to maintain a strange hold on the DSP, reserving control of its=20
>debug
>connections. So, when you try and load a program, set breakpoints or
>otherwise alter the state of the DSP, while linux and the GPP are runnin=
g,
>you will invariably get errors. There are a few things you can do that m=
ake
>things go easier depending on your requirements:
>
>- Reset the jumpers appropriately to turn the board on in DSP only mode.
>This is only good if you don't need access to the peripherals, but its v=
ery
>useful for step by step hardware debugging of major code loops that woul=
d
>run solely on the DSP
>
>- After you have loaded your application from the GPP side through linux
>(Maybe a-la RF6?) you can go to the file menu of CCS and do a "load symb=
ols
>only" which will sync CCS and the code running on the DSP. It may allow =
you
>to set breakpoints, though it is not totally reliable.
>
>Make sure you have the latest version of DSP/BIOS compiled and built wit=
h
>your program, it seems to be less buggy than the default versions. Also
>evaluation versions of CCS 3.1 appear to be less stable. I hope some of=20
>this
>helps.
>
>Thanks,
>Andy
>
> >From: Tung Dang
> >To: linux-omap-open-source@linux.omap.com
> >Subject: Problem with DSP TMS320C55xx on OMAP5912
> >Date: Tue, 31 Oct 2006 23:50:03 -0800 (PST)
> >
> >Hi all,
> >When i using Code Composer Studio (CCS) from TI to simulate the functi=
ons
> >of my program , the CCS verbal a error in the Messages Window :
> >Trouble running Target CPU: Check the linker command file / map file f=
or
> >any part of the program going into reserved area and correct the probl=
em
> >when Program Counter is 0x0  NOTE: Reset the target, reload the correc=
ted
> >program and continue execution
> >Pls help me , what kind of this error ? What is the root problem ?
> >
> >
> >
> >
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >Thank you and Best Regards  !
> >Dang Hoang Tung
> >email : tungsys@yahoo.com
> >Student
> >University of Technology
> >Department of Computer Science
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> >---------------------------------
> >  Check out the New Yahoo! Mail - Fire up a more powerful email and ge=
t
> >things done faster.
> >_______________________________________________
> >Linux-omap-open-source mailing list
> >Linux-omap-open-source@linux.omap.com
> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>_________________________________________________________________
>Find a local pizza place, music store, museum and more=85then map the be=
st
>route!  http://local.live.com?FORM=3DMGA001
>
>
>
>------------------------------
>
>
>
>
>---------------------------------
>Get your email and see which of your friends are online - Right on the  =
new=20
>Yahoo.com

_________________________________________________________________
Try Search Survival Kits: Fix up your home and better handle your cash wi=
th=20
Live Search!=20
http://imagine-windowslive.com/search/kits/default.aspx?kit=3Dimprove&loc=
ale=3Den-US&source=3Dhmtagline
