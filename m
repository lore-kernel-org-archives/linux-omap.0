From: "naga rajan" <nagubk82@gmail.com>
Subject: DSP Gateway application-reg
Date: Sat, 27 May 2006 13:06:44 +0530
Message-ID: <7e6cc7550605270036h2edb26cdvc3f128045dc72acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: toshihiro.kobayashi@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
 Currently we are working on OSK5912 with DSP Gateway application programs
provided along with DSP Gateway version3.3. We verified the wdsnd command
program provided with the demo folder. We have some queries to be clarified
with that particular program (demo_console.c).

* Why we have to send a initial data from ARM to DSP?*
Note: On omitting this process, the program is not able to receive data fro=
m
DSP.

* Why we have to include a "busywait" in the DSP side in this word transfer=
?
*Note:   On excluding "busywait", the data transfer is not proper.

 Please provide solutions for my queries.

Thanks in advance,
B.Nagarajan,
SANDS.
