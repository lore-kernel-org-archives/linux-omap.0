From: "Raghu_Mallya" <Raghu_Mallya@satyam.com>
Subject: Re: Re: Regarding McBSP Int ...help needed... (Matthew Percival)
Date: Tue, 20 Dec 2005 11:22:48 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED101F596EA@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Class: urn:content-classes:message
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


Hi:

Thanks for the reply matthew.=20
I tried your directions  and now my code looks as below.

 Void McBSPRxInterrupt(Void)
 {  =20
       Uns McBSP1Data;
      Uns InterruptStatus;=20
      =20
       //code to check if the interrupt is from McBSP1 or McBSP3
      InterruptStatus =3D inw(_LEV2_SIR_FIQ);
     =20
      =20
 	  McBSP1Data =3D inw(_MCBSP1_DRR1); // copy contents of McBSP
receive
 							//register to
variable
	outw(inw(DSP_L21_CONTROL) | NEW_FIQ_AGR, DSP_L21_CONTROL);

 }

There is indeed a bit a advance in the sense, My ISR is executed twice
now after including ur line of code. But after that no response.=20

I am checking for the ISR execution as below.
First of all I have declared a global variable ie =
cpy=3D0x0000(initialized
to zero) b/w toklibios and ex_task and in the ISR I am incrementing this
variable by one
, In the ex_task.out I am doing a word send of the variable. Before
including your line of code is used to get cpy=3D0x0001 but after ur =
code
is included it get cpy=3D0x0002 and then no increments... not able to
figure out why the ISR stops executing in b/w. any idea about this

Regards

Raghu


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
