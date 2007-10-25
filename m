From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: Problem reading TCR of 32k timer.
Date: Thu, 25 Oct 2007 17:46:39 +0530
Message-ID: <47208927.1070001@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi ,
       I am facing a problem in reading the TCR register of the 32k 
timer. Most of the time the value is correct but some times the value 
read is greater than TVR. I  have  enabled the XOR clock  to read TCR  , 
as mentioned in the TRM. I am using omap f-sample board. any idea why 
this is happening ?

--
Thanks
Vivek
