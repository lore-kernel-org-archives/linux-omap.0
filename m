From: "Taru Varshney" <taru.varshney@intervideo.com>
Subject: Need help to understand a #pragma statment.
Date: Thu, 3 Aug 2006 19:09:07 +0530
Message-ID: <20060803125117.EB139CC02C@pf2.intervideo.com>
References: <20060803130336.GA18147@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060803130336.GA18147@atomide.com>
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
I'm trying to load bootloader on DM320's Flash memory. Flash writer is
working fine. But it's somebody else's code. I'm not able to understand what
the folowing line in the flash Writer code is doing:

#pragma DATA_SECTION (ucBOOT320Code,".bin"). 

Can anybody help me to understand the above line ??

Thanks in Advance,
Taru
  
