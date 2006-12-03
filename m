From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: memset in dsp_task_config_all
Date: Sun, 3 Dec 2006 23:55:00 +0530
Message-ID: <3a5b1be00612031024m30ae1e10i2206d1d8e2259544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>, toshihiro.kobayashi@nokia.com, Hiroshi.DOYU@nokia.com
List-Id: linux-omap@vger.kernel.org

Doyu-San,

Why memset is being called again on dsptask and taskdevices  in
dsp_task_config_all function, which was already done while we
initialized the module (dsp_taskmod_init())?

Also why we are not preferring linked list based approach for
maintaining dsp tasks instead of static array of max 255 dsp tasks and
equal no of taskdevices?

On a real device, I don't see more 10-15 tasks/algorithms running on dsp.

-- 
---Komal Shah
http://komalshah.blogspot.com
