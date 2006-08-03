From: "Taru Varshney" <taru.varshney@intervideo.com>
Subject: New : Please ignore earlier message: Need help to understand a
	#pragma statment.
Date: Thu, 3 Aug 2006 19:42:40 +0530
Message-ID: <20060803132450.13DFDCC081@pf2.intervideo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
I'm trying to load bootloader on DM320's Flash memory. Flash writer is
working fine. But it's somebody else's code. I'm not able to understand what
the folowing #pragma line in the flash Writer code is doing:

#include "BOOT320.h"
#pragma DATA_SECTION (ucBOOT320Code,".bin"). 

ucBOOT320Code is an 1D array defined & initialised with specific values in
BOOT320.h 

Can anybody help me to understand the above line containing #pragma ??

Thanks in Advance,
Taru
  
