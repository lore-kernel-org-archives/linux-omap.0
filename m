From: "shanghai" <jacky_wang@ovt.com.cn>
Subject: OMAP2430 RESET STANDBY GPIO can not set
Date: Fri, 23 Nov 2007 22:07:38 +0800
Message-ID: <20071123140541.M90782@ovt.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=gb2312
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
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi:
	I am working on omap2430sdp for developing camera driver.But I found I can 
not operate the GPIO: STANDBY and RESET pin when I pull it high or set it low?I am 
using kernel2.6.14 and dip S4-S10 setting like this:
S10
1 2 3 4
ON ON ON ON
S9
1 2 3 4 5 6 7 8
ON ON ON ON ON ON ON OFF
S8
1 2 3 4 5 6 7 8
ON ON ON ON ON ON ON OFF
S6
1 2 3 4 5 6 7 8
ON ON OFF OFF OFF OFF OFF ON
S4
1 2 3 4 5 6 7 8
OFF OFF OFF OFF ON ON OFF OFF

should I change the DIP state to enable the camera interface or somewhere in kernel 
need check?
any suggestion are welcome!

--
Open WebMail Project (http://openwebmail.org)
