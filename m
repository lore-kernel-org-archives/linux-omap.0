From: Martin Margraf <m_margraf@web.de>
Subject: setting omap into idle for some ms
Date: Tue, 27 Jun 2006 10:39:53 +0200
Message-ID: <968054735@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
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

hi,

i try to set the osk5912 Rev. D with 2.6.16.18 for 5 ms into idle.
i looked for this and found the nanosleep() function, wich send the omap into sleep for ns-ms. it works fine, but during this sleep
the cpu is 100% busy, wich is a problem, cause i would test the cpu usage of my ecg algorithm. 
i heard that nanosleep uses for sleep times <=2ms a busy loop, but i use 5ms, where is the problem? 

another problem is that i cannot display float in the ttyS0 console. for example:

float i = 3.4143;
printf(".....%f\n",i);  is displayed as long long number
i tried to declare the number as double, same problem. the same with every format like %5.6f.
does someone has the same prob?

regards 

martin
______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193
