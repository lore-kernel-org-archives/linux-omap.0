From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Using dsplink in my application
Date: Thu, 24 Aug 2006 14:46:49 +0400
Message-ID: <9713be7f0608240346x1b7b08a5o2c0500c01422350c@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi everyone!
I'm trying to use dsplink to communicate ARM-linux and DSP. I just
took two working applications (one of them is sample from rf6) and
tried to insert dsplink code to main in my app.
Application built successfully but while starting I got such error:

Reference Framework 6 audio application started
Assertion failed (PMGR_MSGQ_IsInitialized == TRUE). File : pmgr_msgq.c
Line : 282
Assertion failed (LDRV_MSGQ_IsInitialized == TRUE). File : ldrv_msgq.c
Line : 438
Assertion failed (mqaId < LdrvMsgqStateObj.numAllocators). File :
ldrv_msgq.c Line : 441
MSGQ_AllocatorOpen () failed.

What can be the reason for this, where should I dig?
Please advise.
Thanks. Sergey.
