From: "Student" <student@sonsys.de>
Subject: Communication DSP to GPP (RF6)
Date: Fri, 9 Dec 2005 13:33:34 +0100
Message-ID: <009001c5fcbc$c8e21c80$b410a8c0@nb1xp>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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

we work with the omap5912osk.
We are evaluating the reference framework RF6, the manual number is
SPRA796A originally supplied by Texas Instruments. The problem we have
is to establish communication between the GPP and the DSP onboard (cf.
figure 29 omn page 53 of this document). While GPP can transmit messages
and data to the DSP, we don't succeed with communication vice versa,
specifically with the greyed MSGQ (Status Task/DSP -_ Status
pThread/GPP). Therefore we don't see the heartbeats.

I think the error is on the DSP side.
On the GPP side is the MSGQ_create and the DSP-side must locate this message 
queue

Regards,
Andre 
