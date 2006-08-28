From: Arnold <abo_gwapo@yahoo.com>
Subject: I2C Remote I/O error
Date: Mon, 28 Aug 2006 00:13:12 -0700 (PDT)
Message-ID: <20060828071312.59941.qmail@web55812.mail.re3.yahoo.com>
References: <48a4d13c0608240841x32106f3eo92aeeaa448a4de7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <48a4d13c0608240841x32106f3eo92aeeaa448a4de7e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Guys,

I'm using an omap5912 and would like to write and read
thru i2c.  Below are  the debug msg aswell as the
code. 

Debug msg:
#./i2c_test
(OJ) adapter number = OMAP I2C adapter
i: Remote I/O error
written -1 bytes

Code:

#define I2C_SLAVE     0x0703
#define BUFFER_SIZE   32


int adapter_nr = 0;

int addr = 0x40; /* The I2C address */

sprintf(filename,"/dev/i2c-%d",adapter_nr);
  if ((file = open(filename,O_RDWR)) < 0) {
    printf("Error Opening File\n");
    exit(1);
  }

  if (ioctl(file,I2C_SLAVE,addr) < 0) {
    exit(1);
  }
 
if (write(file,buffer,sizeof(char) * BUFFER_SIZE) < 0)
{
        perror("Error Writing:");
        exit(1);
  }
  printf("written %d bytes\n",i);
  memset(buffer,0,BUFFER_SIZE);

  if(read(file,buffer,sizeof(char) * BUFFER_SIZE) < 0
)     {
        perror("Error Reading:");
        exit(1);
  }
  printf("read %d bytes\n",i);
  for(i=0;i<BUFFER_SIZE;i++)
  {
     printf("%c",buffer[i]);
  }
  printf("\n");

  close(file);

Is there someone who knows what the problem is? 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
