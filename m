From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: ARM: OMAP: Select GENERIC_CLOCKEVENTS patch
Date: Tue, 8 May 2007 12:37:07 +0530
Message-ID: <5d5443650705080007v3bb5a154p6883082280e8de47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

"select GENERIC_CLOCKEVENTS" patch makes H4 build with default MPU
timer selected to fail because timer_tick() is only available if
CLOCKEVENTS is not defined.

Do we really need to select GENERIC_CLOCKEVENTS by default? Other
solution is then to add !GENERIC_CLOCKEVENT as dependency in MPU_TIMER
KConfig.

-- 
--Trilok Soni
