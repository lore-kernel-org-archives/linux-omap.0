From: "Raghu_Mallya" <Raghu_Mallya@satyam.com>
Subject: Omap McbSp3 interrupt help plz
Date: Sat, 18 Feb 2006 18:31:57 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED102DF9962@bsdmsg002.corp.satyam.ad>
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
To: dspgateway-devel@lists.sourceforge.net, Ishigami <ishigami@ti.com>, Toshihiro.Kobayashi@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi :


I am trying to configure McBSP3 of omap5910 in order to recive some pcm
data from external pcm codec.


I am getting the access to the mcbsp register and the clock and the
frame sync signals from the mcbsp3 are coming properly(checked in CRO)
but not getting any interrupt properly even once.

Here is my configuration and interrupt setting.

outw(0xFFF5,_LEV2_MIR);	// Enable McBSP3 interrupt
outw(0x0005,_ILR_IRQ1);	// Interrupt Configuration for McBSP3 Rx

outw(0x0033,_DSP_IDLECT2);=09
outw(0x0001,_DSP_RSTCT2);

Void McBSP3Init(Void)
{
	outw(0x0000,_MCBSP3_SPCR1);
	outw(0x0200,_MCBSP3_SPCR2);
	outw(0x0040,_MCBSP3_RCR1);
   	outw(0x0005,_MCBSP3_RCR2);
	outw(0x0040,_MCBSP3_XCR1);=20
	outw(0x0005,_MCBSP3_XCR2);=20

	outw(0x00FF,_MCBSP3_SRGR1);
	outw(0x3010,_MCBSP3_SRGR2);
						=09
	outw(0x0F00,_MCBSP3_PCR);
	//after reset
}

ISR:
Void McBSPRxInterrupt(Void)
{  =20
	InterruptStatus =3D inw(_LEV2_SIR_FIQ);
	dbg(&task_anon,"ADC Interrupt %x\n",ADCStatus);
	if(InterruptStatus =3D=3D 1)
	{
      	ADCStatus =3D inw(_MCBSP3_DRR1); //copy contents of McBSP3
//receieve reg=20
      	dbg(&task_anon,"ADC Interrupt %x\n",ADCStatus);
    	}
      outw(0x0002,_DSP_CONTROL);   =20
}

Similar stuff work fine with mcbsp1 and is fully operational at my end.

I am getting the transmitt ready bit and reciev reday bit also but not
the interrupt.

Anybody who has done mcbsp3 configuration on DSPside in omap5910
especially using DSPgateway please help me in this regard

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
