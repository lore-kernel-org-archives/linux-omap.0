From: Anoop Krishnan <Anoop.Krishnan@lntinfotech.com>
Subject: DSP BIOS problem in OMAP1510 Innovator
Date: Mon, 13 Mar 2006 14:17:09 +0530
Message-ID: <OF9DC9495F.26D3A005-ON65257130.002F545F-65257130.00304474@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi all,

I am trying to implement a MP3 Decoder running in the DSP.
I am using Linux DSP Tools to compile for DSP. I am also using DSP Gateway 
& tokliBIOS.
But the DSP is hanging after sometime. I tried to debug by putting dbg() 
calls.
>From that I could see that the user task is hanging in SEM_pend() call.
I am not able to debug furthur. Could anyone please give suggestions on 
how to approach this problem?
Thanks in advance.

Anoop

______________________________________________________________________
