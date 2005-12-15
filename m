From: "Raghu_Mallya" <Raghu_Mallya@satyam.com>
Subject: Regarding McBSP Int ...help needed...
Date: Thu, 15 Dec 2005 18:12:32 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED101E3A3EA@bsdmsg002.corp.satyam.ad>
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
Cc: Toshihiro.Kobayashi@nokia.com, KishoreKumar sannapaneni <nandanakishore@yahoo.co.in>
List-Id: linux-omap@vger.kernel.org

Hi:

Although not a very Linux oriented question, many of you have already
worked on this... I am facing a problem as below..

Overview
********
I am using DSP gateway for intercommunication process between ARM and
DSP in OMAP5910(custom Board). On the DSP side I am trying to read the
data from the external PCM  through McBSP1 and trying to send the
receiving data to ARM using DSP gateway.

Problem
********
I am getting the first interrupt in the McBSP1 properly. But after this
my ISR dies off ie becomes inactive. I am not able to get any
interrupts.. My ISR code is as below


Void McBSPRxInterrupt(Void)
{  =20
      Uns McBSP1Data;
     Uns InterruptStatus;=20
     =20
      //code to check if the interrupt is from McBSP1 or McBSP3
     InterruptStatus =3D inw(_LEV2_SIR_FIQ);
    =20
     if(InterruptStatus & 0x0002)
     {
     =20
	  McBSP1Data =3D inw(_MCBSP1_DRR1); // copy contents of McBSP
receive
//register to variable
     =20
	}
=09
}

As given in the Omap Manual the int mask get unmasked as soon as we read
the SIR_FIQ register...  Am I doing some mistake...??? PLz help

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
