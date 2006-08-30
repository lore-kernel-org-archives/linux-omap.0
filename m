From: Prashant <prashantkhoje@gmail.com>
Subject: OMAP1710 Innovator: problem with Full Duplex Audio
Date: Wed, 30 Aug 2006 14:50:36 +0530
Message-ID: <7b1b9c8b0608300220t798d6e58t326ef195320e45f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi All,
I am working on OMAP1710 ES 2.0. I have Linux 2.6.9 kernel.
OMAP1710 audio works fine in half duplex mode.
But when I try running it in full duplex mode I get errors. Ctrl+C can
stop the audio test application. I have pasted the trace at the end of message.

Does 2.6.9 kernel support full duplex audio?
Do I need to apply any patches in order to get it working? Where can I
get those patches?

Thank you,
Prashant

error trace:
# ./test_omap1710 -f 8000 -F 7 -G -1 -t 10 -l
Loopback mode selected
Chunk: 640 Bit: 16 Freq: 8000 Chan: 2
10 msec data calculated as 320 bytes
Using OSS
caps=3300
Fragment size set to 128
Frags limited by driver
au_open: getblksize 00000080 nblks=0 blklen=128
fmt=10
Set channels: 2
au_open : freq 8000 : ch 2
Set writelen: 128
...returned
Call Max Send Space - first time
Max Send Space: 130432
Sending data...
max_tx: 130560
Stuff 60 msec
VE_AUDIO_SendSpace: ramp up completed (1006 frags)

{audio_process_dma}-ERROR: Called again while In Use
{audio_process_dma}-ERROR: Called again while In Use
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
......
