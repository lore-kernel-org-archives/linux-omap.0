From: Matthew Percival <matthew@capgo.com>
Subject: Re: Regarding McBSP Int ...help needed...
Date: Fri, 16 Dec 2005 09:31:40 +1100
Message-ID: <1134685901.8910.3.camel@localhost.localdomain>
References: <D8595042F3765A4285B848A78A2C2ED101E3A3EA@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED101E3A3EA@bsdmsg002.corp.satyam.ad>
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

G'Day,

> Void McBSPRxInterrupt(Void)
> {   
>       Uns McBSP1Data;
>      Uns InterruptStatus; 
>       
>       //code to check if the interrupt is from McBSP1 or McBSP3
>      InterruptStatus = inw(_LEV2_SIR_FIQ);
>      
>      if(InterruptStatus & 0x0002)
>      {
>       
> 	  McBSP1Data = inw(_MCBSP1_DRR1); // copy contents of McBSP
> receive
> //register to variable
>       
> 	}
> 	
> }

	It looks like you have the start right, but the end is missing
something.  Here is an ISR from my DSP code:

void level21_handler(Arg arg)
{
	MdUns irq = read_reg(DSP_L21_SIR_FIQ);
	timer_handler();
	write_reg(read_reg(DSP_L21_CONTROL) | NEW_FIQ_AGR, DSP_L21_CONTROL);
}

	You need to write NEW_FIQ_AGR to DSP_L20_CONTROL (L2.0 for McBSP; L2.1
here because it is a GPTimer) at the end of your ISR.  If I am
remembering correctly, this tells the Interrupt module that you have
completed servicing the current interrupt, and for it to calculate the
next interrupt to be serviced.  This is in a 5912, but there should be
something equivalent in the 5910.

	-- Matthew
