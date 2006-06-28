From: "naga rajan" <nagubk82@gmail.com>
Subject: Codec problem with kernel2.6.11
Date: Wed, 28 Jun 2006 10:29:57 +0530
Message-ID: <7e6cc7550606272159n5705ba8cge3835f1798dbfb89@mail.gmail.com>
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

Hi all,

        I tried to obtain the samples from the audio-codec as mentioned in
the osk4dummies. While executing the appropriate command, i got the
following errors....

#dd bs=48k count=5 < /dev/dsp > hello.wav
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1,
T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2
QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1,
T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2
QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1,
T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
{audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
{audio_dsr_handler}-ERROR: nbfrag=8,pendfrags=0,USR-H=2, QH-2 QT-7
5+0 records in
5+0 records out

I could not able to identify what went wrong.Please provide a solution for
this problem.

Thanks in advance,
B.Nagarajan,
SANDS.
